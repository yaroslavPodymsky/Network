pragma ton-solidity >= 0.43;

pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

import "./debot-interfaces/Debot.sol";
import "./debot-interfaces/Terminal.sol";
import "./debot-interfaces/Menu.sol";
import "./debot-interfaces/Network.sol";



contract debot is Debot {

    function start() public override {
        Terminal.print(0, "");
        restart();
    }

    function restart() public {
        MenuItem[] items;
        items.push(MenuItem("get request", "", tvm.functionId(getNetwork)));
        Menu.select("Menu:", "", items);
    }
    function getNetwork() public {
        string[] headers;
        bytes url = "https://raw.githubusercontent.com/yaroslavPodymsky/CodeHashExampl/main/string.tvc";
        headers.push("text");
        Network.get(tvm.functionId(setGetResponse), url, headers);
    }

    function setGetResponse(int32 statusCode, string[] retHeaders, string content) public {
        Terminal.print(0, content);
        restart();
    }

    function getRequiredInterfaces() public view override returns (uint256[] interfaces) {
        return [ Terminal.ID, Network.ID];
    }

    function getDebotInfo() public functionID(0xDEB) view override returns(
        string name, string version, string publisher, string key, string author,
        address support, string hello, string language, string dabi, bytes icon) {
        name = "Network Example";
        version = "0.1.0";
        publisher = "TON Labs";
        key = "Example Debot for Network Interface";
        author = "TON Labs";
        support = address(0);
        hello = "Hello, I'm example DeBot.";
        language = "en";
        dabi = m_debotAbi.get();
        icon = "";
    }
}

