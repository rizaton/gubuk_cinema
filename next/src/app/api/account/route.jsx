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
                bookmark: []
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
    return Response.json({result : resdata})
}


// Update
export async function PUT(Request){
    const data = await Request.json()
    const params = Request.nextUrl.searchParams;
    const id = params.get("id")

    console.log(typeof data.username)
    const db = await client.db("gubukcinema")
    if(data.username !== undefined){
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

    return Response.json({data})
}

export async function DELETE(Request){
    const data = await Request.json()

    console.log(data.id)
    const db = await client.db("gubukcinema")
    await db.collection("account").deleteOne(
        {
            _id: new ObjectId(data.id)
        }
    )
    return Response.json({data})
}