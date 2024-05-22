"use client";

import { useRouter } from "next/navigation";
import { BiSearch } from "react-icons/bi";
import { HiHome } from "react-icons/hi";
import { RxCaretLeft, RxCaretRight } from "react-icons/rx";
import { twMerge } from "tailwind-merge";
import Button from "./Button";
import useAuthModal from "@/hooks/useAuthModal";
import { useSupabaseClient } from "@supabase/auth-helpers-react";
import { useUser } from "@/hooks/useUser";
import Image from "next/image";
import toast from "react-hot-toast";

interface HeaderProps {
  children: React.ReactNode;
  className?: string;
}

const Header: React.FC<HeaderProps> = ({ children, className }) => {
  const authModal = useAuthModal();
  const router = useRouter();

  const supabaseClient = useSupabaseClient();
  const { user } = useUser();

  const handleLogout = async () => {
    const { error } = await supabaseClient.auth.signOut();
    router.refresh();

    if (error) {
      toast.error(error.message);
    } else {
      toast.success("Logged out!");
    }
  };

  return (
    <div
      className={twMerge(
        `
                h-fit
                bg-gradient-to-b
                from-gradient1
                p-6
            `,
        className,
      )}
    >
      <div
        className="
                    w-full
                    mb-4
                    flex
                    items-center
                    justify-between
            "
      >
        <div
          className="
                    hidden
                    md:flex
                    gap-x-2
                    items-center
                "
        >
          <button
            onClick={() => router.back()}
            className="
                            rounded-full
                            bg-background0
                            flex
                            items-center
                            justify-center
                            hover:opacity-75
                            transition
                        "
          >
            <RxCaretLeft className="text-primary" size={35} />
          </button>
          <button
            onClick={() => router.back()}
            className="
                            rounded-full
                            bg-background0
                            flex
                            items-center
                            justify-center
                            hover:opacity-75
                            transition
                        "
          >
            <RxCaretRight className="text-primary" size={35} />
          </button>
        </div>
        <div className="flex md:hidden gap-x-2 items-center">
          <button
            onClick={() => router.push("/")}
            className="
                            rounded-full
                            p-2
                            bg-primary
                            flex
                            items-center
                            justify-center
                            hover:opacity-75
                            transition
                        "
          >
            <HiHome className="text-tertiary" size={20} />
          </button>
          <button
            onClick={() => router.push("/search")}
            className="
                            rounded-full
                            p-2
                            bg-primary
                            flex
                            items-center
                            justify-center
                            hover:opacity-75
                            transition
                        "
          >
            <BiSearch className="text-tertiary" size={20} />
          </button>
        </div>
        <div
          className="
                        flex
                        justify-between
                        items-center
                        gap-x-4
                    "
        >
          {user ? (
            <div className="flex gap-x-4 items-center">
              <Button onClick={handleLogout} className="bg-primary px-6 py-2">
                Logout
              </Button>
              <Button
                onClick={() => router.push("/account")}
                className="relative w-12 h-10"
              >
                <Image
                    src={'/images/no_avatar_path.png'}
                    alt="Avatar"
                    layout="fill"
                    objectFit="cover"
                    className="rounded-full"
                />
              </Button>
            </div>
          ) : (
            <>
              <div>
                <Button
                  onClick={authModal.onOpen}
                  className="
                                        bg-transparent
                                        text-primary/80
                                        font-medium
                                    "
                >
                  Sign up
                </Button>
              </div>
              <div>
                <Button
                  onClick={authModal.onOpen}
                  className="
                                        bg-primary
                                        px-6
                                        py-2
                                    "
                >
                  Log in
                </Button>
              </div>
            </>
          )}
        </div>
      </div>
      {children}
    </div>
  );
};

export default Header;
