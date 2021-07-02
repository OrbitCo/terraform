#!/usr/bin/env groovy

@Library(['com.optum.jenkins.pipelines.templates.terraform@master', 'com.optum.jenkins.pipeline.library@master']) _

// email notifications for build status
def email (String status) {
    String subject = "${JOB_NAME} build ${BUILD_NUMBER}: ${status}"
    String body = ""
    try {
        body += "<p>Version = ${VERSION}<br>"
    }
    catch (Exception ex) {}
    body += "URL = ${BUILD_URL}</p>"

    try {
        unstash 'failure'
        String content = readFile("failure.txt")
        body += "<p><b>Failure Reason</b><br>${content}</p>"
    } 
    catch (Exception ex) {}

    try {
        body += "${CHANGES}"
    }
    catch (Exception ex) {}

    try{
        unstash 'summary'
        String content = readFile('reports/summary.html')
        body += content
    }
    catch (Exception ex) {}

    emailext(
        from: "noreply_jenkinsDS@optum.com",
        to: "${EMAIL_RECIPIENTS}",
        subject: "${subject}",
        body: "${body}",
        attachLog: true,
        mimeType: "text/html"
    )
}

// Deploy the terraform configuration
// See https://github.optum.com/jenkins-pipelines/template-terraform
echo 'before azurepipeline'
pipeline {
    agent {
        label 'docker-maven-slave'
    }
    environment {
        EMAIL_RECIPIENTS = "e1ae3d68.uhgazure.onmicrosoft.com@amer.teams.ms"
    }
    stages {
        stage('Build Binding Extensions') {

            steps {
                script {
                    sh '''
                    # Run mixins (provides the `dotnet` binary)
                    . /etc/profile.d/jenkins.sh
                    '''
                    def envvariables = readJSON file: "environmentvariables.json"
                    env.ARM_SUBSCRIPTION_ID = envvariables.dev['ARM_SUBSCRIPTION_ID']
                    env.ARM_CLIENT_ID = envvariables.dev['ARM_CLIENT_ID']
                    env.ARM_CLIENT_SECRET = envvariables.dev['ARM_CLIENT_SECRET']
                    env.ARM_TENANT_ID = envvariables.dev['ARM_TENANT_ID']
                    env.TFVARS_INIT_PATH = envvariables.dev['TFVARS_INIT_PATH']
                    env.TFVARS_PLAN_APPLY_PATH = envvariables.dev['TFVARS_PLAN_APPLY_PATH']
                }
            }
        }

        stage('Terraform Plan') {
        	environment {
                sp = azureServicePrincipal('ServicePrincipalCredentials_nonprod')
            }
            steps {
                script{
                    echo "Entering deployment"
                    echo "${TFVARS_INIT_PATH}"
                    echo "${TFVARS_PLAN_APPLY_PATH}"
                    withCredentials([azureServicePrincipal('ServicePrincipalCredentials_nonprod')]) {
                        sh "az login --service-principal -u ${AZURE_CLIENT_ID} -p ${AZURE_CLIENT_SECRET} -t ${AZURE_TENANT_ID} --allow-no-subscriptions"
                        sh '''
                            terraform -version
                            terraform init -no-color -backend-config="${TFVARS_INIT_PATH}"
                            terraform plan -no-color -var-file="${TFVARS_PLAN_APPLY_PATH}"
                        '''
                    }
                }
            }  
        }

        stage('Terraform Apply'){
            steps{
                script{
                    timeout(time: 15, unit: 'MINUTES') {
                        input 'Do you want to apply the terraform changes?'
                    }
                    sh ''' 
                        terraform apply -no-color -auto-approve -var-file="${TFVARS_PLAN_APPLY_PATH}"
                    '''
                }
            }
        }
    }
    post {
        success {
            echo 'Deployment successful.'
            email('SUCCESS')
        }
        failure {
            echo 'Deployment failed.'
            email('FAILURE')
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
            email('UNSTABLE')
        }
    }
}
