import { Request, Response } from "express"
import { createLogger, transports } from 'winston';
import { LoggingWinston } from '@google-cloud/logging-winston';
import PubsubEvent = GoogleCloudPlatform.CloudFunctions.PubsubEvent
import StorageEvent = GoogleCloudPlatform.CloudFunctions.StorageEvent
import Callback = GoogleCloudPlatform.CloudFunctions.Callback

/*
const pubsub  = require("@google-cloud/pubsub")({
    keyFilename: "/path/to/keyfile.json",
    projectId: "grape-spaceship-123"})
console.log(pubsub)
*/



// set up logging (note FUNCTION_TARGET has replaced FUNCTION_NAME as reserved env var)
const loggingWinston = new LoggingWinston({ 'logName': process.env['FUNCTION_TARGET'] });
const logger = createLogger({
    level: 'info',
    transports: [
        // goes to functions log
        new transports.Console(),
        // goes to named log, under "Global" resource
        loggingWinston,
    ],
});



export function helloWorldHTTP(req: Request, res: Response) {
    logger.info("Hello");
    logger.warn("uh-oh");
    res
        .status(200)
        .type("application/json")
        .send("{ \"result\": \"Hello World!\"}\n")
        .end()
}

export function helloWorldPubSub(event: PubsubEvent, callback: Callback) {
    console.log("Hello World! I have got event from Google Cloud Pub/Sub topic: ", event.data)
    callback()
}

export function helloWorldStorage(event: StorageEvent, callback: Callback) {
    console.log("Hello World! I have got event from Google Cloud Storage bucket: ", event.data)
    callback()
}
