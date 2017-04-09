pipeline {
  agent any
  stages {
    stage('') {
      steps {
        parallel(
          "Test": {
            sh 'echo hi'
            
          },
          "Test1": {
            sh 'echo hello'
            
          }
        )
      }
    }
  }
}