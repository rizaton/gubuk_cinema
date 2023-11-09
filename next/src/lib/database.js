import { MongoClient } from 'mongodb'
const uri = process.env.MONGODB_URI

const client = new MongoClient(uri)
client.connect


export default client;