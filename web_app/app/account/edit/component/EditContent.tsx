"use client"

import useLoadAvatar from "@/hooks/useLoadAvatar";
import { Settings } from "@/types";
import Image from "next/image";

interface AccountContentProps {
    data: Settings;
}

const AccountContent: React.FC<AccountContentProps> = ({
    data
}) => {
    const imageUrl = useLoadAvatar(data);
    const onSubmit = () => {
    };
    // TODO: possibility to change his name
    // TODO: possibility to change his profile picture
    // TODO: choose a theme between spotify (green), scratify (blue), smeagolify (or) and sithify (red)
    return (
        <div className="flex flex-col items-center space-y-4">
            <div className="relative w-36 h-36">
                <Image
                    src={imageUrl || '/images/no_avatar_path.png'}
                    alt="Avatar"
                    layout="fill"
                    objectFit="cover"
                />
            </div>
            <div>
                <p className="text-primary">{data.name}</p>
                <p className="mt-3">
                    <u className="text-primary">Theme:</u> <br />
                    <span className="text-gradient2">pinguin</span>
                </p>
            </div>
        </div>
    );
}

export default AccountContent;