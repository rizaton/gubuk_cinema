import client from "@/lib/database"
import { ObjectId } from 'bson'

export async function POST(Request){
    const data = await Request.json()
    const params = Request.nextUrl.searchParams;
    const id = params.get("id")

    const db = await client.db("gubukcinema")
    const noted = []

    if(data.username !== undefined){
        const getusername = await db.collection("account")
            .findOne(
                {
                    username : data.username 
                }
            )
        if(getusername !== null){
            noted.push("Username Tidak Tersedia")
        }
        else{     
            await db.collection("account").updateOne(
                {
                    _id: new ObjectId(id)
                },
                {
                    $set: {
                        "username": data.username,
                    }
                }
            )
        }
    }
    if(data.fullname !== undefined){
        await db.collection("account").updateOne(
            {
                _id: new ObjectId(id)
            },
            {
                $set: {
                    "fullname": data.fullname,
                }
            }
        )
    }
    if(data.email !== undefined){
        await db.collection("account").updateOne(
            {
                _id: new ObjectId(id)
            },
            {
                $set: {
                    "email": data.email,
                }
            }
        )
    }
    if(data.password !== undefined){
        await db.collection("account").updateOne(
            {
                _id: new ObjectId(id)
            },
            {
                $set: {
                    "password": data.password,
                }
            }
        )
    }
    if(data.bookmark !== undefined){
        await db.collection("account").updateOne(
            {
                _id: new ObjectId(id)
            },
            {
                $set: {
                    "bookmark": data.bookmark,
                }
            }
        )
    }

    return Response.json({message: 'Successfuly!', error : noted},
        {
            status: 200,
            headers: {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                'Access-Control-Allow-Headers': 'Content-Type, application/json',
            },
        }
    )
}