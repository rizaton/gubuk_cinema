import client from "@/lib/database"
import { ObjectId } from 'bson'

export async function GET(Request){
    const db = await client.db("gubukcinema")
    const params = Request.nextUrl.searchParams;


    if(params.get("username") !== null){
        const username = params.get("username")

        if(username !== null){
            const account = await db
                .collection("account")
                .findOne({username: username})
            if(account?.username !== undefined){
                return Response.json( account,
                    {
                        status: 200,
                        headers: {
                            'Access-Control-Allow-Origin': '*',
                            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                            'Access-Control-Allow-Headers': 'Content-Type, Authorization',
                        },
                    }
                )
            }
            else{
                return Response.json( "Username tidak Ada!",
                    {
                        status: 200,
                        headers: {
                            'Access-Control-Allow-Origin': '*',
                            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                            'Access-Control-Allow-Headers': 'Content-Type, Authorization',
                        },
                    }
                )
            }
        }
    }
    else{
        const result = await db
                .collection("account")
                .find({})
                .sort({ metacritic: -1 })
                .limit(0)
                .toArray();
        return Response.json( result,
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
}

export async function POST(Request) {
    const data = await Request.json()
    const db = await client.db("gubukcinema")
    
    if(data.username !== null){
        const account = await db
            .collection("account")
            .findOne({username: data.username})
        
        if(account?.username === undefined){
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
                    }
                )
            } catch (e) {
                console.error(e)
            }
            return Response.json('Successfuly!',
            {
                status: 200,
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
                },
            })
        }
        else{
            return Response.json('Username not Available!',
            {
                status: 200,
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
                },
            })
        }

    }

    
}

export async function DELETE(Request){
    const data = await Request.json()
    const db = await client.db("gubukcinema")
    await db.collection("account").deleteOne(
        {
            _id: new ObjectId(data.id)
        }
    )
    return Response.json('Successfuly!',
    {
        status: 200,
        headers: {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type, Authorization',
        },
    }
)
}