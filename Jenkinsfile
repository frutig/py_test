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
        pip install -r requirements.txt
      }
    }
    stage('Linting') {
      steps {
      	    sh 'python3 -m pylint --output-format=parseable --fail-under=<10> module --msg-template="{path}:{line}: [{msg_id}({symbol}), {obj}] {msg}" | tee pylint.log || echo "pylint exited with $?"'
	    echo "linting Success, Generating Report"
	    recordIssues enabledForFailure: true, aggregatingResults: true, tool: pyLint(pattern: 'pylint.log')
      }
    }
    stage('Unit Testing') {
      steps {
        sh 'python3 -m unittest tests/unit.py'
      }
    }
    stage('Integration Testing') {
      steps {
        sh 'python3 -m unittest tests/integration.py'
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

