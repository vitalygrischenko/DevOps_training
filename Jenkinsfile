def version = ''
def buildName = ''
withCredentials([usernamePassword(credentialsId: 'git_user', passwordVariable: 'git_pass', usernameVariable: 'git_name'), usernamePassword(credentialsId: 'nexus_user', passwordVariable: 'nexus_pass', usernameVariable: 'nexus_name')]) {
node('master') {
   stage('Git checkup') { // clones git repository
      dir('task6'){
        git branch: 'task6', url: 'https://github.com/vitalygrischenko/DevOps_training.git'
      }
   }
   stage('Buildind project') { // building project
      dir('task6'){
        sh '/opt/gradle/gradle-3.4.1/bin/gradle incVersion'
        sh '/opt/gradle/gradle-3.4.1/bin/gradle build'
      }
   }
   
  
   stage('Determining the build version'){
       dir('task6/build/libs'){
        String snapshotBase="libs"
        new File(pwd()).eachFileRecurse{file->
            buildName=file.name.replace(".war","")
        }
       }
        println buildName
        dir('task6'){
          Properties properties = new Properties()
          sh 'ls'
          File propertiesFile = new File(pwd()+'/gradle.properties')
          def props = readProperties  file: pwd()+'/gradle.properties'
          version = props.version+'.'+props.buildVersion
          println version
       }
   }
   stage('Upload to nexus') { // upload to nexus repository
      dir('task6'){
         sh "curl -v -u ${nexus_name}:${nexus_pass} --upload-file build/libs/${buildName}.war http://localhost:8081/nexus/content/repositories/snapshots/${buildName}/${version}/${buildName}.war"
    
      }
   }
}

node('tomcat1'){
    stage('downloading'){
        httpRequest outputFile: "${buildName}.war", responseHandle: 'NONE', url: "http://172.16.0.10:8081/nexus/service/local/repositories/snapshots/content/${buildName}/${version}/${buildName}.war"
    }
    stage('upgrading tomcat1'){
        httpRequest responseHandle: 'NONE', url: 'http://172.16.0.10/jkmanager?cmd=update&from=list&w=lb&sw=tomcat1&vwa=1'
        sh "cp ${buildName}.war /usr/share/tomcat/webapps/"
        sleep 10
        httpRequest responseHandle: 'NONE', url: 'http://172.16.0.10/jkmanager?cmd=update&from=list&w=lb&sw=tomcat1&vwa=0'
    }
}
node('tomcat2'){
    stage('downloading'){
        httpRequest outputFile: "${buildName}.war", responseHandle: 'NONE', url: "http://172.16.0.10:8081/nexus/service/local/repositories/snapshots/content/${buildName}/${version}/${buildName}.war"
    }
    stage('upgrading tomcat2'){
        httpRequest responseHandle: 'NONE', url: 'http://172.16.0.10/jkmanager?cmd=update&from=list&w=lb&sw=tomcat2&vwa=1'
        sh "cp ${buildName}.war /usr/share/tomcat/webapps/"
        sleep 10
        httpRequest responseHandle: 'NONE', url: 'http://172.16.0.10/jkmanager?cmd=update&from=list&w=lb&sw=tomcat2&vwa=0'
    }
}
node('master') {
    stage('Git save') {
        dir('task6') {
          sh 'git config --global user.email "vitalygrischenko#gmail.com"'
          sh 'git config --global user.name "vitalygrischenko"'
          sh 'git add *'
          sh "git commit -m 'new version ${version}'"
          sh "git push https://${git_name}:${git_pass}@github.com/vitalygrischenko/DevOps_training.git --all"
          sh 'git checkout master'
          sh 'git merge task6'
          sh "git tag -a v${version} -m 'version ${version}'"
          sh 'git push https://${git_name}:${git_pass}@github.com/vitalygrischenko/DevOps_training.git --tags'
          sh 'git push https://${git_name}:${git_pass}@github.com/vitalygrischenko/DevOps_training.git --all'
       } 
    }
}
}
