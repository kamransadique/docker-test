FROM node:alpine as buildstage
WORKDIR '/app'
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# expose port for aws elasticbeanstalk
EXPOSE 80
COPY --from=buildstage /app/build /usr/share/nginx/html
