import Header from "@/components/Header";
import AccountContent from "./component/AccountContent";
import getAccountSettings from "@/actions/getAccountSettings";

const Account = async () => {
    const AccountSettings = await getAccountSettings();
    return (
        <div
            className="
                bg-background
                rounded-lg
                h-full
                w-full
                overflow-hidden
                overflow-y-auto
            "
        >
            <Header>
                <div className="mb-2 flex flex-col gap-y-6 items-center">
                    <h1 className="text-primary text-3xl font-semibold mb-8">
                        Account Settings
                    </h1>
                </div>
            </Header>
            <div className="mb-7 px-6">
                {AccountSettings.map((data) => (
                    <AccountContent data={data}/>
                ))}
            </div>
            
        </div>
    );
}

export default Account;