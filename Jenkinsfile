pipeline {
  agent any 
	
  tools {
    maven 'Maven'
  }
  def buildNumber = BUILD_NUMBER	
  stages {
    
    stage ('Initialize') {
      steps {
        sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
            ''' 
      }
    }   
    stage ('Build') {
      steps {
      sh 'mvn clean package'
       }
    }
    stage("Building Docker Image"){
	    steps{
		    sh'docker build -t jagadeeshreddybhimireddy/java-web-app-docker:${buildNumber} .'
	    }
    }	    
	  
  }
}
