pipeline {
  agent any

  tools {
    // if you installed NodeJS tool in Jenkins (Manage Jenkins -> Global Tool Config)
    // name must match the tool name you added. Remove if not using NodeJS plugin.
    nodejs 'NodeJS_18' 
  }

  environment {
    // fill if you plan to deploy later
    DEPLOY_USER = 'ubuntu'
    DEPLOY_HOST = 'YOUR_DEPLOY_HOST_OR_IP'
    SSH_CRED = 'ssh-credentials-id'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Install') {
      steps {
        script {
          if (isUnix()) {
            sh 'npm ci'
          } else {
            bat 'npm ci'
          }
        }
      }
    }

    stage('Test') {
      steps {
        script {
          if (isUnix()) {
            sh 'npm test'
          } else {
            bat 'npm test'
          }
        }
      }
    }

    stage('Build') {
      steps {
        script {
          if (isUnix()) {
            sh 'npm run build'
          } else {
            bat 'npm run build'
          }
        }
      }
    }

    stage('Archive') {
      steps {
        archiveArtifacts artifacts: 'dist/**', allowEmptyArchive: true
      }
    }

    /* Optional deploy example (uncomment and configure)
    stage('Deploy') {
      steps {
        sshagent (credentials: [SSH_CRED]) {
          script {
            if (isUnix()) {
              sh '''
                scp -o StrictHostKeyChecking=no -r ./dist ${DEPLOY_USER}@${DEPLOY_HOST}:/home/${DEPLOY_USER}/app
                ssh -o StrictHostKeyChecking=no ${DEPLOY_USER}@${DEPLOY_HOST} "sudo systemctl restart myapp || true"
              '''
            } else {
              // On Windows agent: ensure OpenSSH/pscp is available
              bat '''
                pscp -batch -r .\\dist %DEPLOY_USER%@%DEPLOY_HOST%:/home/%DEPLOY_USER%/app
              '''
            }
          }
        }
      }
    }
    */
  }

  post {
    always {
      junit '**/test-results/**/*.xml' // if your tests generate JUnit XML
      echo "Build finished: ${currentBuild.currentResult}"
    }
  }
}
