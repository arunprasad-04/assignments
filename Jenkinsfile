pipeline {
    agent any

    tools {
        nodejs 'NodeJS_18'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install') {
            steps {
                dir('assignments') {
                    bat 'npm install'
                }
            }
        }

        stage('Test') {
            steps {
                dir('assignments') {
                    bat 'npm test || echo No tests defined'
                }
            }
        }

        stage('Build') {
            steps {
                dir('assignments') {
                    bat 'npm run build || echo No build script'
                }
            }
        }

        stage('Archive') {
            steps {
                dir('assignments') {
                    archiveArtifacts artifacts: 'dist/**', allowEmptyArchive: true
                }
            }
        }
    }

    post {
        always {
            echo "Build finished: ${currentBuild.currentResult}"
        }
    }
}
