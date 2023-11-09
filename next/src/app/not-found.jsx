"use client"

import { FileSearch } from "@phosphor-icons/react";
import Link from "next/link";

const NotFound = () => {
    return(
    <div className="flex justify-center items-center py-4 text-black">
        <div className="flex justify-center items-center gap-4 flex-col">
            <FileSearch size={32} className=""/>
            <h3 className="font-bold text-3xl">Not Found</h3>
            <Link href="/" className="hover:text-indigo-400 underline">Kembali</Link>
        </div>
    </div>
    )
}

export default NotFound;