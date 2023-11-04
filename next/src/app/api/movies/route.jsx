import client from "@/lib/database"

export async function GET(req, res){
    
    const db = await client.db("gubukcinema")
    const movies = await db
            .collection("movies")
            .find({})
            .sort({ metacritic: -1 })
            .limit(0)
            .toArray();
    return Response.json({data : movies})
}