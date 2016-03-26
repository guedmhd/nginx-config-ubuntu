server {
    listen 80;
    listen [::]:80;

    # The www host name.
    server_name www.example.com;

    # Redirect to the non-www.
    return 301 $scheme://example.com$request_uri;
}

server {
    listen 80;
    listen [::]:80;

    # The host name.
    server_name example.com;

    # The root path.
    root /usr/share/nginx/example.com;

    # Specify charset.
    charset utf-8;

    # Index file.
    index index.html index.htm;

    # Try file then directory, or else 404.
    location / {
        try_files $uri $uri/ =404;
    }

    # Custom 404 error page.
    error_page 404 /404.html;

    # Log file path.
    error_log  /etc/nginx/logs/example.com_error.log warn;
    access_log /etc/nginx/logs/example.com_access.log main;

    # Include basic config.
    include conf.d/basic.conf;
}
