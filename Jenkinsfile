pipeline {
agent any
    environment {
        PROJECT_ID = 'jenkins-project-249206'
        CLUSTER_NAME = 'kubernetes-cluster-jenkins'
        LOCATION = 'us-central1-a'
        CREDENTIALS_ID = 'jenkins-project-249206'
    }

    tools {
        maven 'maven3'
    }

    stages {
        stage('Preparation') { // for display purposes
            steps{
                // Get some code from a GitHub repository
                git branch: 'demo', url: 'https://github.com/prathamghadge/tomcat-example.git'

            }
        }

        stage('Run Tests') {
            steps{
                sh 'sleep 1'
            }
        }

        stage('Build') {
            steps{
                sh 'mvn clean install'
            }
        }

        stage('Archive Artifacts') {
            steps{
                archiveArtifacts 'target/*.war'
            }
        }

//        stage('Build image') {
//            app = docker.build("gcr.io/jenkins-project-249206/demo-app")
//            steps{
//                sh 'docker build -t gcr.io/jenkins-project-249206/demo-app .'
//            }
//        }

        stage('Build & Publish Image and Helm') {
            steps {
                    script {
                        def app = docker.build("gcr.io/jenkins-project-249206/demo-app")
                        docker.withRegistry('https://gcr.io', 'gcr:jenkins-project-249206') {
                        // app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }

        stage('Deploy to Dev') {
            steps{
                sh 'sleep 1'
            }
        }

        stage('Run Tests @ Dev') {
            steps{
                sh 'sleep 1'
            }
        }

        stage('Clean Up @ Dev') {
            steps{
                sh 'sleep 1'
            }
        }

        stage('Deploy to Staging') {
            steps{
                sh 'sleep 1'
            }
        }

        stage('Run Tests @ Staging') {
            steps{
                sh 'sleep 1'
            }
        }

        stage('Clean Up @ Staging') {
            steps{
                sh 'sleep 1'
            }
        }

        stage('Deploy to Production ?') {
            steps{
                input message: 'Deploy to Production?', submitterParameter: 'approver'
            }
        }

        stage('Deploy to GKE') {
            steps{
                step([
                $class: 'KubernetesEngineBuilder',
                projectId: env.PROJECT_ID,
                clusterName: env.CLUSTER_NAME,
                location: env.LOCATION,
                manifestPattern: 'manifests/',
                credentialsId: env.CREDENTIALS_ID
                ])
            }
        }
    }
}