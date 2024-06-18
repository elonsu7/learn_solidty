// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Yeye {
    event Log(string msg);

    function hip() public virtual {
        emit Log("msg");
    }

    function hop() public virtual {
        emit Log("msg");
    }

    function yeye() public virtual  {
        emit Log("msg");
    }
}

contract Baba is Yeye {
    function hip() public virtual override {
        emit Log("baba");
    }

    function hop() public virtual override {
        emit Log("baba");
    }

    function baba() public {
        emit Log("baba");
    }

    function callYeye() public {
        Yeye.hop();
    }
}

contract Erzi is Yeye,Baba { //按照继承顺序写
    function hip() public virtual override(Baba, Yeye) {
        emit Log("erzi");
    }
    function hop() public override(Baba, Yeye) {
        emit Log("erzi");
    }

    function superCall() public {
        super.hop();
    }

}

// contract Base1 {
//     modifier exactDividedBy2And3(uint _a) virtual {
//         require(_a % 2 == 0 && _a % 3 == 0);
//         _;
//     }
// }

// contract Identifier is Base1 {
//     modifier exactDividedBy2And3(uint _a) override {
//         _;
//         require(_a % 2 == 0 && _a % 3 == 0);
//     }

//     function getExactDividedBy2And3(uint _a) public pure exactDividedBy2And3(_a) returns(uint, uint){
//         return getExactDividedBy2And3WithoutModifier(_a);
//     }

//     function getExactDividedBy2And3WithoutModifier(uint _dividend) public pure returns(uint, uint){
//         uint div2 = _dividend / 2;
//         uint div3 = _dividend / 3;
//         return (div2, div3);
//     }
// }

// 构造函数的继承
// abstract contract A {
//     uint public a;

//     constructor(uint _a) {
//         a = _a;
//     }
// }

// contract B is A(1) {
//     uint public b;

//     constructor(uint _b) {
//         b = _b;
//     }
// }

// contract C is A {
//     uint public c;

//     constructor(uint _c) A(_c) {
//         c = _c;
//     }
// }

// 钻石继承 调用合约people中的super.bar()会依次调用Eve、Adam，最后是God合约
contract God {
    event Log(string message);

    function foo() public virtual {
        emit Log("God.foo called");
    }

    function bar() public virtual {
        emit Log("God.bar called");
    }
}

contract Adam is God {
    function foo() public virtual override {
        emit Log("Adam.foo called");
    }

    function bar() public virtual override {
        emit Log("Adam.bar called");
        super.bar();
    }
}

contract Eve is God {
    function foo() public virtual override {
        // emit Log("Eve.foo called");
        super.foo();
    }

    function bar() public virtual override {
        emit Log("Eve.bar called");
        super.bar();
    }
}

contract Man is Adam, Eve {
    function foo() public override(Adam, Eve) {
        super.foo();
    }

    function bar() public override(Adam, Eve) {
        super.bar();
    }
}
