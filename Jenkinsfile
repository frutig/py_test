pipeline {
  options {
     buildDiscarder(logRotator(numToKeepStr: '10')) // Retain history on the last 10 builds
     ansiColor('xterm') // Enable colors in terminal
     timestamps() // Append timestamps to each line
     timeout(time: 20, unit: 'MINUTES') // Set a timeout on the total execution time of the job
   }
  agent {
    dockerfile { filename 'Dockerfile.build' }
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }

    }
    stage('Setup') {
      steps {
        script {
          sh """
          pip install -r requirements.txt
          """
        }
      }
    }
    stage('Linting') {
      steps {
        script {
          sh """
          pylint **/*.py
          """
        }
      }
    }
    stage('Unit Testing') {
      steps {
        script {
          sh """
          python3 -m unittest discover -s tests/unit
          """
        }
      }
    }
    stage('Integration Testing') {
      steps {
        script """
        python -m unittest discover -s tests/integration
        """
      }
    }

  }
  post {
    success {
      msg = "Deploy succeeded for #{params.DEPLOY_APP} #{params.DEPLOY_VER} " +
              "to #{params.DEPLOY_ENV} #{ (${env.BUILD_URL})"
        echo $msg
      }
    failure {
      script {
        msg = "Build error for ${env.JOB_NAME} ${env.BUILD_NUMBER} (${env.BUILD_URL})"
        echo $msg
      }
     }
  }
}
