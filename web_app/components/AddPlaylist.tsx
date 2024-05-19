"use client";

import useAddPlaylist from "@/hooks/useAddPlaylist";
import Modal from "./Modal";
import { FieldValues, SubmitHandler, useForm } from "react-hook-form";
import { useState } from "react";
import Input from "./Input";
import Button from "./Button";
import toast from "react-hot-toast";
import { useUser } from "@/hooks/useUser";
import uniqid from "uniqid";
import { useSupabaseClient } from "@supabase/auth-helpers-react";
import { useRouter } from "next/navigation";


const AddPlaylist = () => {
    const [isLoading, setIsLoading] = useState(false);
    const addPlaylist = useAddPlaylist();
    const { user } = useUser();
    const supabaseClient = useSupabaseClient();
    const router = useRouter();

    const {
        register,
        handleSubmit,
        reset
    } = useForm<FieldValues>({
        defaultValues: {
            name: '',
        }
    })

    const onChange = (open: boolean) => {
        if (!open) {
            reset();
            addPlaylist.onClose();
        }
    }

    const onSubmit: SubmitHandler<FieldValues> = async (values) => {
        // TODO: Playlist submit
        reset();
        addPlaylist.onClose();
    }

    return (
        <Modal
            title="Add a playlist"
            description="creation of a new playlist"
            isOpen={addPlaylist.isOpen}
            onChange={onChange}
        >
            <form
                onSubmit={handleSubmit(onSubmit)}
                className="flex flex-col gap-y-4"
            >
                <Input
                    id="name"
                    disabled={isLoading}
                    {...register('title', {required : true})}
                    placeholder="Playlist name"
                />
                <Button disabled={isLoading} type="submit">
                    Create
                </Button>
            </form>
        </Modal>
    );
}

export default AddPlaylist;