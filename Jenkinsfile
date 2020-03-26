pipeline {
    agent any
    environment {
        registry = "md-registry.epfl.ch/payonline"
        registryCredential = 'md-registry'
        dockerImage = ''
    }
    stages {
        stage('Preparation') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/develop']],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [[$class: 'SubmoduleOption',
                        disableSubmodules: false,
                        parentCredentials: true,
                        recursiveSubmodules: true,
                        reference: '',
                        trackingSubmodules: false]],
                    submoduleCfg: [],
                    userRemoteConfigs: [[credentialsId: 'c4science', url: 'ssh://git@c4science.ch/diffusion/7764/payonline-epfl-ch.git']]
                ])
            }
        }
        stage('Build image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":latest"
                }
            }
        }
        stage('Push image') {
            steps {
                script {
                    docker.withRegistry('https://md-registry.epfl.ch', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}