pipeline {
  agent {
    kubernetes {
      label 'kaniko-build'
      yaml """
kind: Pod
metadata:
  name: rtt-kaniko
spec:
  containers:
  - name: jnlp
    workingDir: /tmp/jenkins
  - name: kaniko
    workingDir: /tmp/jenkins
    image: gcr.io/kaniko-project/executor:debug
    imagePullPolicy: Always
    command:
    - /busybox/cat
    tty: true
    volumeMounts:
      - name: jenkins-docker-cfg
        mountPath: /kaniko/.docker
  volumes:
  - name: jenkins-docker-cfg
    projected:
      sources:
      - secret:
          name: registry-brokenpip3
          items:
            - key: .dockerconfigjson
              path: config.json
"""
    }
  }
    stages {
        stage('Make Image') {
            environment {
                PATH        = "/busybox:$PATH"
                IMAGE       = 'rtt'
                TAG         = 'latest'
            }
            steps {
              withFolderProperties{
                container(name: 'kaniko', shell: '/busybox/sh') {
                    sh '''#!/busybox/sh
                    /kaniko/executor -f Dockerfile -c `pwd` --cache=true --destination=${REGISTRY}/${REPOSITORY}/${IMAGE}:${TAG}
                    '''
                }}
            }
        }
    }
}
