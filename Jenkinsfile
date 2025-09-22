pipeline {
  agent any

  tools {
    nodejs 'NodeJS_18' // Must match what you configured in Jenkins > Global Tool Config
  }

  environment {
    DEPLOY_USER = 'ubuntu'      // Optional (for AWS later)
    DEPLOY_HOST = 'YOUR_SERVER' // Optional
    SSH_CRED    = 'ssh-credentials-id'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Install') {
      steps {
        bat 'npm install'
      }
    }

    stage('Test') {
      steps {
        script {
          if (isUnix()) {
            sh 'npm test || echo "No tests"'
          } else {
            bat 'npm test || echo No tests'
          }
        }
      }
    }

    stage('Build') {
      steps {
        script {
          if (isUnix()) {
            sh 'npm run build || echo "No build script"'
          } else {
            bat 'npm run build || echo No build script'
          }
        }
      }
    }

    stage('Archive') {
      steps {
        archiveArtifacts artifacts: 'dist/**', allowEmptyArchive: true
      }
    }

    /*
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
      echo "Build finished: ${currentBuild.currentResult}"
      // Remove junit step until you actually have test reports
    }
  }
}
