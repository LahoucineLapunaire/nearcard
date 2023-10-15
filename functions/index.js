const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const cors = require("cors")({ origin: true });

exports.getEmailFromUid = functions
  .region("europe-west3")
  .https.onRequest((request, response) => {
    cors(request, response, () => {
      try {
        const uid = request.body.data.uid;
        if (uid === undefined) {
          return response.status(400).send({"error":"uid is undefined"});
        }
        var email = "";
        admin.auth().getUser(uid).then((userRecord) => {
          return response.send({data: {"email": userRecord}});
        });
      }catch (error) {
        console.log("Error: ", error);
        return response.status(500).send({data: {"error":error}});
      }
    });
  });
/*
  exports.helloWorld = functions
  .region("europe-west3")
  .https.onRequest((request, response) => {
    cors(request, response, () => {
      try {
        return response.send({data: {"message": "Hello World"}});
      } catch (error) {
        console.log("Error: ", error);
        return response.status(500).send({data: {"error":error}});
      }
    });
  });
*/