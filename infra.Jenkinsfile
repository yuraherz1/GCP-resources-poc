pipeline {
    /// agent any
    agent {
      label 'ubuntu_local'
    }
  parameters {
    choice(name: 'INFRA_COMPONENT', choices: ['vpc'], description: 'Choose component.')
    choice(name: 'ENV', choices: ['dev', 'sit'], description: 'Choose environment.')
    choice(name: 'ACTION', choices: ['plan', 'apply', 'destroy'], description: 'Choose action.')
  }

  environment {
    COMPONENT = sh(script: """echo `echo ${params.INFRA_COMPONENT}`""", returnStdout: true).trim()
    ENV = sh(script: """echo `echo ${params.ENV}`""", returnStdout: true).trim()
  }
  stages {
    stage('TF plan') {
      when {
        allOf {
          expression {return (params.ACTION == "plan" || params.ACTION == "apply"
          && (ENV != "uat" || ENV != "prd"))}
        }
        beforeAgent true
      }
      steps {
        dir("infra/${COMPONENT}/env/${ENV}") {
          withCredentials([file(credentialsId: 'GCP-credentials-file', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
          // withCredentials([[ $class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS-Terraform-Execution']]) {
          // withEnv(['AWS_PROFILE=AdministratorAccessExceptIAM-680159267871']) { // use profile with custom SSO session and command: aws sso login --sso-session AWS-Avenga-Education-SSO
            echo 'Plan to create Terraform resources...'
            script {
            sh '''
              cp ./../../*.tf ./../../configs/*.json ./../../configs/*.yaml ./
              terraform init
              terraform workspace new ${ENV} || terraform workspace select ${ENV}
              terraform validate
              terraform plan -var-file=./${ENV}.tfvars -out=deploy.tfpaln
            '''
            }
          }
        }
      }
    }
    stage('TF apply') {
      when {
        allOf {
          expression {return (params.ACTION == "apply" && (ENV != "uat" || ENV != "prd"))}
        }
        beforeAgent true
      }
      steps {
        dir("infra/${COMPONENT}/env/${ENV}") {
          withCredentials([file(credentialsId: 'GCP-credentials-file', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
          // withCredentials([[ $class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS-Terraform-Execution']]) {
            echo 'Create Terraform resources...'
            script {
            sh '''
              terraform apply deploy.tfpaln
            '''
            }
          }
        }
      }
    }
    stage('TF destroy') {
      when {
        allOf {
          expression {return (params.ACTION == "destroy" && (ENV != "uat" || ENV != "prd"))}
        }
        beforeAgent true
      }
      steps {
        dir("infra/${COMPONENT}/env/${ENV}") {
          withCredentials([file(credentialsId: 'GCP-credentials-file', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
          // withCredentials([[ $class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS-Terraform-Execution']]) {
            echo 'Destroy Terraform resources...'
            script {
            sh '''
              terraform init
              terraform workspace new ${ENV} || terraform workspace select ${ENV}
              terraform validate
              terraform destroy -var-file=./${ENV}.tfvars -auto-approve=true
            '''
            }
          }
        }
      }
    }
  }
}
