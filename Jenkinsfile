pipeline {
    agent any
    environment {
        PROJECT_ID = 'decent-slice-334812'
                CLUSTER_NAME = 'adjust-gke-cluster'
                LOCATION = 'europe-west2-c'
                CREDENTIALS_ID = 'kubernetess'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build image') {
            steps {
                script {
                    app = docker.build("rohitkotla/httpwebapp:${env.BUILD_ID}")
                    }
            }
        }
        
        stage('Push image') {
            steps {
                script {
                    withCredentials( \
                                 [string(credentialsId: 'dockerhub',\
                                 variable: 'dockerhub')]) {
                        sh "docker login -u rohitkotla -p ${dockerhub}"
                    }
                    app.push("${env.BUILD_ID}")
                 }
                                 
            }
        }
    
        stage('Deploy to GKE') {
            steps('Apply Kubernetes files') {
                withKubeConfig([credentialsId: 'kubernetess', serverUrl: 'https://34.105.136.45']) {
                sh '/usr/local/bin/kubectl apply -f deploymentservice.yml'
          }
        }
      }
    }   
}