import client from "@/lib/database"
import { ObjectId } from 'bson'

export async function GET(req, res){
    const db = await client.db("gubukcinema")
    
    const account = await db
            .collection("account")
            .find({})
            .sort({ metacritic: -1 })
            .limit(0)
            .toArray();
    return Response.json({data : account})
}

export async function POST(Request) {
    const data = await Request.json()
    const db = await client.db("gubukcinema")

    try{
        await db
        .collection("account")
        .insertOne(
            {
                _id : new ObjectId,
                username: data.username,
                fullname: data.fullname,
                email: data.email,
                password: data.password,
                role: data.role,
                bookmark: data.bookmark
            }
        )
    } catch (e) {
        console.error(e)
    }

    const resdata = {
        status: 200,
        result: data,
        message: "Successful"
    }

    //console.log(data)
    return Response.json({result : resdata})
}