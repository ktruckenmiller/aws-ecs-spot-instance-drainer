'use strict';

const Hapi = require('hapi');

const server = Hapi.server({
  port: 51678,
  load: {
    sampleInterval: 1000
  }
});

server.route({
    method: 'GET',
    path: '/v1/metadata',
    handler: function (request, reply) {

      console.log('got agent request')
        return {
          "Cluster":"webapp2",
          "ContainerInstanceArn":"arn:aws:ecs:us-west-2:{{someaccount}}:container-instance/{{instance_id}}",
          "Version":"Amazon ECS Agent - v1.16.0 (1ca656c)"
        }
    }
});
server.route({
    method: 'GET',
    path: '/latest/meta-data/spot/termination-time',
    handler: function (request, reply) {
      console.log('request coming in')
        let action = process.env.SPOT_ACTION || "stop"
        if (action === "404") {
          return reply.response('The page was not found').code(404);
        } else {
          return {
            "action": action,
            "time": "2017-09-18T08:22:00Z"
          }
        }

    }
});
const boston = async () => {
  await server.start()
}
boston()
