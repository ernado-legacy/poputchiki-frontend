from fabric.api import run, local, env, cd


env.hosts = ['root@msk1.cydev.ru:122']
root = '/src/poputchiki-frontend/'


def update():
    ver = local('git rev-parse HEAD', capture=True)
    with cd(root):
        remote_ver = run('git rev-parse HEAD')
        print('updating production to version %s' % ver)
        run('git reset --hard')
        run('git pull origin master')
        run('sed "s/VERSION/%s/g" Dockerfile.template > Dockerfile' % ver)
        run('docker build -t d.cydev.ru/poputchiki-frontend .')
        run('~/poputchiki-frontend.sh')
