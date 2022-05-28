#!/usr/bin/env sh

# flutter packages run model_generator
# flutter pub run build_runner build
#flutter build web --source-maps --profile --dart-define=Dart2jsOptimization=O0
flutter build web
rsync -az --delete build/web/ moon:/home/paul/web/

ssh root@moon "
    rsync -a --delete /home/paul/web/ /var/lib/caddy/data/meuua.com/
    chown -R caddy:caddy /var/lib/caddy/data/meuua.com
    chcon -R -u system_u -r object_r -t httpd_var_lib_t /var/lib/caddy/data/meuua.com
"
