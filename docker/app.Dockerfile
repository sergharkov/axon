FROM node:20.12.1

RUN mkdir -p /app
RUN mkdir -p /var/log/app
RUN apt-get update -y
RUN apt-get install -y iputils-ping


WORKDIR /app

COPY ./  .
RUN npm install -g @nestjs/cli
RUN yarn install

COPY . .


#CMD ["sh", "yarn run dev"]
EXPOSE 3001

