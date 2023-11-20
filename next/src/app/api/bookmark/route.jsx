import client from "@/lib/database"
import { ObjectId } from 'bson'

export async function GET(Request){
    const db = await client.db("gubukcinema")
    const params = Request.nextUrl.searchParams;

    if(params.get("id_bookmark") !== null){
        const id_bookmark = params.get("id_bookmark")
        const bookmark = await db.collection("bookmark")
            .findOne({
                _id: new ObjectId(id_bookmark)
            })
        return Response.json( bookmark,
            {
                status: 200,
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                    'Access-Control-Allow-Headers': 'Content-Type, application/json',
                },
            }
        );
    }
    else if(params.get("id_user") !== null){
        const id_user = params.get("id_user")
        const bookmark = await db.collection("bookmark")
            .findOne({
                id_user : new ObjectId(id_user)
            })
        return Response.json( bookmark,
            {
                status: 200,
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                    'Access-Control-Allow-Headers': 'Content-Type, application/json',
                },
            }
        );
    }
    else{

        try{
            const bookmark = await db.collection("bookmark")
                .find({})
                .sort({ metacritic: -1 })
                .limit(0)
                .toArray();
                return Response.json( bookmark,
                    {
                        status: 200,
                        headers: {
                            'Access-Control-Allow-Origin': '*',
                            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                            'Access-Control-Allow-Headers': 'Content-Type, application/json',
                        },
                    }
                );
        } catch (e) {
            console.error(e)
        }
    }
}

export async function POST(Request){
    const db = await client.db("gubukcinema")
    const params = Request.nextUrl.searchParams;
    const data = await Request.json();

    if(params.get("id_user") !== null){
        const id_user = params.get("id_user")
        const bookmark = await db.collection("bookmark")
            .findOne({
                id_user : new ObjectId(id_user)
            })
        if(bookmark?.id_user === undefined){
            try{
                await db
                .collection("account")
                .insertOne(
                    {
                        _id : new ObjectId,
                        id_user: new ObjectId(id_user),
                        bookmark_movie: []
                    }
                )
            } catch (e) {
                console.error(e)
            }
            return Response.json('New Bookmark created was Successfuly!',
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
            if(data.bookmark_movie !== undefined){
                const bookmark_movie = data.bookmark_movie;
                await db.collection("bookmark").updateOne(
                    {
                        id_user: new ObjectId(id_user)
                    },
                    {
                        $set: {
                            "bookmark_movie" : bookmark_movie
                        }
                    }
                )
                return Response.json(`bookmark untuk id user: ${id_user} sudah di tambah!`,
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
    else{
        return Response.json('Parameternya salah!',
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

export async function DELETE(Request){
    const data = await Request.json()
    const db = await client.db("gubukcinema")

    await db.collection("account").deleteOne(
        {
            id_user: new ObjectId(data.id_user)
        }
    )
    return Response.json('Delete was Successfuly!',
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