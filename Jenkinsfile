// Define variable
import java.time.LocalDateTime
final LocalDateTime currentTime = LocalDateTime.now()
pipeline {
    agent any
	parameters {
        string (
			name: 'PATH',
            defaultValue: 'artifacts',
            description: 'Please left as default or pass a remote directory.')
    }
    stages {    
         /* checkout repo */           
       // stage('Checkout SCM') {
         //   steps {
           //     checkout([
             //    $class: 'GitSCM',
               //  branches: [[name: 'master']],
                 //userRemoteConfigs: [[
                   // url: 'https://github.com/AMXjavaproject/firstjavaproject.git',
               //  ]]
               // ])
           // }
       // }
         stage('Compile') {
            steps {
                sh 'javac -d  bin/ src/*.java'
            }
        }
        stage('Build') {
            steps {
                sh 'cd bin/ ; jar cvfm Library.jar MANIFEST.MF  *.class'
            }
        }
       
        stage('Publish Artifact') {
        steps([$class: 'BapSshPromotionPublisherPlugin']) {
            sshPublisher(
                continueOnError: false, failOnError: true,
                publishers: [
                    sshPublisherDesc(
                        configName: "remote",
                        verbose: true,
                        transfers: [
                            sshTransfer(sourceFiles: "**/Library.jar"),
				sshTransfer(execCommand: "mkdir -p ${params.PATH}/${currentTime} ; mv bin/Library.jar ${params.PATH}/${currentTime} ; rm -rf bin ")
                        ]
                    )
                ]
            )
        }
    }
    }
}
