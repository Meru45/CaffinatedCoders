FROM node:lts-alpine

WORKDIR /app
ARG PAT
ARG USER_NAME
ARG USER_EMAIL

COPY package*.json .

RUN apk add git

RUN echo "${PAT}" > personal_access_token
RUN chmod 600 personal_access_token
RUN git config --global user.name "${USER_NAME}}"
RUN git config --global user.email "${USER_EMAIL}}"

RUN git clone https://"${USER_NAME}}":"${PAT}"@github.com/Meru45/CC-backend.git
RUN git clone https://"${USER_NAME}}":"${PAT}"@github.com/Meru45/CC-client.git

RUN npm run install-CC-client --omit=dev
RUN npm run install-CC-backend --omit=dev
RUN npm run build-path --prefix CC-client

USER node

CMD ["npm", "start", "--prefix", "CC-backend"]

EXPOSE 4000