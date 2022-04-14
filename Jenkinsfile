pipeline {
  agent any 	
  tools {
    maven 'Maven'
  }
  	
  stages {
    
    stage ('Initialize') {
      steps {
        sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
            ''' 
      }
    }
	  
    stage('Static SNYK Scan') {

	steps{
        snykSecurity failOnError: false, organisation: 'jagadeesh4321indian', projectName: 'webapp', snykInstallation: 'Snyk', snykTokenId: 'jagadeesh4321indian'
		}
	}
	 
    stage ('Build') {
      steps {
      sh 'mvn clean package'
       }
    }
    stage("Building Docker Image"){
	    steps{
		    sh'docker build -t jagadeeshreddybhimireddy/java-web-app-docker .'
	    }
    }
    stage("Docker Hub Login and Push"){
	    steps{
		    withCredentials([string(credentialsId: 'Docker_Hub_Pwd', variable: 'Docker_Hub_Pwd')]) {
			    sh'docker login -u jagadeeshreddybhimireddy -p ${Docker_Hub_Pwd}'
		      }
		    
		    sh'docker push jagadeeshreddybhimireddy/java-web-app-docker'
	    }
	}	    
    stage("Deploying Docker Container with webapp to Prod Server"){
	    steps{
		    sshagent(['Docker_Prod_Server_SSH']) {
                        sh 'ssh -o StrictHostkeyChecking=no ec2-user@172.31.95.161 docker rm -f javawebappcontainer || true'
			    
			sh 'ssh -o StrictHostkeyChecking=no ec2-user@172.31.95.161 docker run -d -p 8080:8080 --name javawebappcontainer jagadeeshreddybhimireddy/java-web-app-docker'
                        }
	          }
	}
  }
}
