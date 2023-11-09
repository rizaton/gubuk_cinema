import client from "@/lib/database"
import { ObjectId } from 'bson'

export async function GET(Request){
    const db = await client.db("gubukcinema")
    const params = Request.nextUrl.searchParams;


    if(params.get("username") !== null){
        const username = params.get("username")

        const account = await db
            .collection("account")
            .find({})
            .sort({ metacritic: -1 })
            .limit(0)
            .toArray();

        const result = []

        for(let i = 0; i < account.length; i++){
            if(account[i].username.toLowerCase().includes(username) === true){
                result.push(account[i])
            }
        }

        return Response.json( result,
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
                        bookmark: []
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


// Update
export async function PUT(Request){
    const data = await Request.json()
    const params = Request.nextUrl.searchParams;
    const id = params.get("id")

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