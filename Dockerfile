FROM node:17-alpine3.12 as builder

ENV workspace=/workspace

COPY . ${workspace}

WORKDIR ${workspace}

RUN npm install -g pnpm

RUN pnpm install && pnpm build



FROM nginx:alpine as dist

ENV workspace=/workspace

COPY --from=builder ${workspace}/dist/ /usr/share/nginx/html

EXPOSE 80

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD [ "nginx","-g","daemon off;" ]

