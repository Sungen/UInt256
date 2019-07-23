//
//  UInt256TestArithmetic.swift
//  UInt256
//
//  Created by Sjors Provoost on 06-07-14.
//

@testable import UInt256
import XCTest

class UInt256TestArithmetic: XCTestCase {
    
    #if DEBUG
        let million = 1000
    #else
        let million = 1_000_000
    #endif

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testEquality() {
        let a = UInt256(decimalString: "115792089237316195423570985008687907852589419931798687112530834793049593217026")
        let b = UInt256(decimalString: "115792089237316195423570985008687907852589419932798687112530834793049593217026")

        var res = false

        measure {
            for _ in 1 ... million {
                res = a != b
            }
        }

        XCTAssertTrue(res, "")
    }

    func testCompare() {
        let a = UInt256(decimalString: "115792089237316195423570985008687907852589419931798687112530834793049593217026")
        let b = UInt256(decimalString: "115792089237316195423570985008687907852589419932799687112530834793049593217026")

        var res = false

        measure {
            for _ in 1 ... million {
                res = b > a
            }
        }

        XCTAssertTrue(res, "")
    }

    func testAdd() {
        let a = UInt256(decimalString: "14")
        let b = UInt256(decimalString: "26")
        let c = UInt256(decimalString: "40")

        XCTAssertEqual(a + b, c, "a + b = c")
    }

    func testAddHex() {
        let a = UInt256(hexString: "14")
        let b = UInt256(hexString: "26")
        let c = UInt256(hexString: "3A")

        XCTAssertEqual(a + b, c, "a + b = c")
    }

    func testAddBig() {
        let a = UInt256(decimalString: "14000000123400000001")
        let b = UInt256(decimalString: "26000000123400000001")
        let c = UInt256(decimalString: "40000000246800000002")

        XCTAssertEqual(a + b, c, "\(a) + \(b) = \(c)")
    }

    func testAddBigHex() {
        let a = UInt256(hexString: "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF") // 128 bit
        let b = UInt256(hexString: "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE") // 128 bit
        let sum = UInt256(hexString: "1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD") // 129 bit

        var result: UInt256 = 0

        measure {
            for _ in 1 ... million {
                result = a + b
            }
        }

        XCTAssertEqual(result, sum, result.toHexString)
    }

    func testSubtract() {
        let a = UInt256(decimalString: "40")
        let b = UInt256(decimalString: "26")
        let c = UInt256(decimalString: "14")

        XCTAssertEqual(a - b, c, "a - b = c")
    }

    func testSubtractHex() {
        let a = UInt256(hexString: "3A")
        let b = UInt256(hexString: "26")
        let c = UInt256(hexString: "14")

        XCTAssertEqual(a - b, c, "a - b = c")
    }

    func testSubtractBig() {
        let a = UInt256(hexString: "40000000000000000000")
        let b = UInt256(hexString: "26000000000000000001")
        let c = UInt256(hexString: "19FFFFFFFFFFFFFFFFFF")

        XCTAssertEqual(a - b, c, "a - b = c")
    }

    func testSubtractBigger() {
        let a = UInt256(decimalString: "489155902448849041265494486330585906971")
        let b = UInt256(decimalString: "340282366920938463463374607431768211297")

        let c = UInt256(decimalString: "148873535527910577802119878898817695674")

        var res: UInt256 = 0

        measure {
            for _ in 1 ... million / 100 {
                res = a - b
            }
        }

        XCTAssertEqual(a - b, c, "a - b = c")
    }

    func testSquare131070() {
        let a = UInt256(decimalString: "131070")
        let b = UInt256(decimalString: "131070")
        let product = UInt256(decimalString: "17179344900") // 33 bits

        let res: UInt256 = a * b

        XCTAssertEqual(res, product, res.description)
    }

    func testMultiplyShouldNotMutate() {
        let a = UInt256(decimalString: "32")
        let b = UInt256(decimalString: "2")
        let c = UInt256(decimalString: "64")

        var res: UInt256 = a * b
        res = a * b

        XCTAssertEqual(res, c, "Res mutated to \(res)")
    }

    func testSquareUInt60Max() {
        let a = UInt256(hexString: "FFFFFFF")
        let c = UInt256(hexString: "FFFFFFE0000001")

        let res: UInt256 = a * a

        XCTAssertEqual(res, c, res.description)
    }

    func testMultiplyUInt64MaxWith3() {
        let a = UInt256(hexString: "FFFFFFFFFFFFFFFF") // UInt64.max
        let b = UInt256(hexString: "3") // 0b0011

        let c = UInt256(hexString: "2FFFFFFFFFFFFFFFD")

        let res: UInt256 = a * b

        XCTAssertEqual(res, c, res.description)
    }

    func testSquareUInt64Max() {
        let a = UInt256(hexString: "FFFFFFFFFFFFFFFF") // UInt64.max
        let c = UInt256(hexString: "FFFFFFFFFFFFFFFE0000000000000001")

        let res: UInt256 = a * a

        XCTAssertEqual(res, c, res.description)
    }

    //    func testMultiplyOverflow() {
    //        let a = UInt256(hexString: "8888888888888888888888888888888888888888888888888888888888888888")
    //        let b = UInt256(hexString: "0000000000000000000000000000000000000000000000000000000000000002")
    //        let c = UInt256(hexString: "1111111111111111111111111111111111111111111111111111111111111110")
    //
    //        // Should crash:
    //        let res = a * b
    //
    //        // Unsafe multiply is not supported, so this will crash as well:
    //        let res = a &* b
    //
    //        XCTAssertTrue(res == c, "")
    //    }

    func testMultiplyToTuple() {
        let a = UInt256(hexString: "8888888888888888888888888888888888888888888888888888888888888888")
        let b = UInt256(hexString: "0000000000000000000000000000000000000000000000000000000000000002")
        let c = (UInt256(hexString: "0000000000000000000000000000000000000000000000000000000000000001"), UInt256(hexString: "1111111111111111111111111111111111111111111111111111111111111110"))

        // Should crash: let res = a * b

        let (resLeft, resRight) = a * b
        let (cLeft, cRight) = c

        XCTAssertTrue(resLeft == cLeft && resRight == cRight, "( \(resLeft), \(resRight) )")
    }

    func testModuloFromTuple() {
        let tuple = (UInt256(hexString: "33F23902074835C68CC1630F5EA81161C3720765CC78C137D6434422659760CC"), UInt256(hexString: "493EF0F253A03B4AB649EA632C432258F7886805422976F65A3E63DE32D809D8"))

        let p = UInt256(hexString: "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F")

        let modulo = UInt256(hexString: "8FF2B776AAF6D91942FD096D2F1F7FD9AA2F64BE71462131AA7F067E28FEF8AC")

        let result = tuple % p

        XCTAssertEqual(result, modulo, result.toHexString)
    }

    func testDivide() {
        let a = UInt256(decimalString: "640")
        let b = UInt256(decimalString: "4")
        let c = UInt256(decimalString: "160")

        let res = a / b

        XCTAssertEqual(res, c, "\(a) / \(b) = \(res) != \(c)")
    }

    func testModulo() {
        let a = UInt256(decimalString: "23")
        let b = UInt256(decimalString: "5")
        let c = UInt256(decimalString: "3")

        let res = a % b

        XCTAssertEqual(res, c, res.description)
    }

    func testModuloLarger() {
        let a = UInt256(decimalString: "25000000000000000000000000000000000000000000000000000000000000000000000004")
        let b = UInt256(decimalString: "5000000000000000000000000000000000000")
        let c = UInt256(decimalString: "4")

        let res = a % b

        XCTAssertEqual(res, c, "\(a) % \(b) = \(res) != \(c)")
    }

    func testModuloMoreComplex() {
        let a = UInt256(decimalString: "2145932040592314323128185")
        let b = UInt256(decimalString: "897983433434")
        let c = UInt256(decimalString: "3")

        let res = a % b

        XCTAssertEqual(res, c, "\(a) % \(b) = \(res) != \(c)")
    }

    func testDivideBig() {
        let a = UInt256(decimalString: "115792089237316195423570985008687907852589419931798687112530834793049593217025")
        let b = UInt256(decimalString: "340282366920938463463374607431768211455")
        let c = UInt256(decimalString: "340282366920938463463374607431768211455")

        var res: UInt256 = 0

        measure {
            for _ in 1 ... million / 100 {
                res = a / b
            }
        }

        XCTAssertEqual(res, c, "\(a) / \(b) = \(res) != \(c)")
    }

    func testModuloLargest128bitPrime() {
        // According to http://primes.utm.edu/lists/2small/100bit.html, 2^128-159 is prime
        // According to Ruby that's: 340282366920938463463374607431768211297

        var a = UInt256(decimalString: "340282366920938463463374607431768211298")
        var b = UInt256(decimalString: "340282366920938463463374607431768211297")
        var c = UInt256(decimalString: "1")

        var res = a % b

        XCTAssertEqual(res, c, "\(a) % \(b) = \(res) != \(c)")

        // (2**128 - 159) * 55 + 5 (according to Ruby)
        a = UInt256(decimalString: "18715530180651615490485603408747251621340")
        b = UInt256(decimalString: "340282366920938463463374607431768211297")
        c = UInt256(decimalString: "5")

        res = a % b

        // Fails:
        XCTAssertEqual(res, c, "\(a) % \(b) = \(res) != \(c)")
    }

    func testModuloBig() {
        let a = UInt256(decimalString: "115792089237316195423570985008687907852589419931798687112530834793049593217026")
        let b = UInt256(decimalString: "340282366920938463463374607431768211455")

        var res: UInt256 = 0

        measure {
            for _ in 1 ... million / 100 {
                res = a % b
            }
        }

        let c = UInt256(decimalString: "1")

        XCTAssertEqual(res, c, "")
    }

    func testModularMultiplicativeInverse() {
        let a = UInt256(hexString: "2b80697edf28a916d822b9b89a8f770fb70d49f48b5c184f2f47f652db960baa")
        let m = UInt256(hexString: "fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f")

        let aInverse = UInt256(hexString: "7ae012558f0053523a39cfe291c0fea21d2c23f41a3805c1c487c93aa83fdac1")

        var res: UInt256 = 0

        measure {
            for _ in UInt16(0) ... UInt16(million / 100_000) {
                res = a.modInverse(m)
            }
        }

        XCTAssertEqual(res, aInverse, res.toHexString)
    }

    func testModularMultiplicativeInverseSmall() {
        let p: UInt256 = 11
        let a: UInt256 = 5

        let inverse: UInt256 = 9 // 9  * 5 = 45 -> 45 % 9 = 1

        let result = a.modInverse(p)

        XCTAssertEqual(inverse, result, result.toDecimalString)
    }

    func testMultiplyToMax32Bit() {
        let a = UInt256(decimalString: "65535")
        let c = UInt256(decimalString: "4294836225")

        var res: UInt256 = 0

        measure {
            for _ in 1 ... million {
                res = a * a // 0.9999...% of 32 bit max
            }
        }

        XCTAssertEqual(res, c, res.description)
    }

    func testMultiplyToMax64Bit() {
        let a = UInt256(decimalString: "4294967295")
        let c = UInt256(decimalString: "18446744065119617025")

        var res: UInt256 = 0

        #if DEBUG
            res = a * a // 0.9999999...% of 64 bit max
        #else
            measure {
                for _ in 1 ... million {
                    res = a * a
                }
            }
        #endif

        XCTAssertEqual(res, c, res.description)
    }

    func testMultiplyToMax128BitNoKaratsubaOverflow() {
        var a = UInt256(hexString: "1000200030004000")
        var c = UInt256(hexString: "10004000a0014001900180010000000")

        var res: UInt256 = 0

        res = a * a

        XCTAssertEqual(res, c, res.toHexString)

        res = 0

        a = UInt256(decimalString: "8373049358093547092")
        c = UInt256(decimalString: "70107955553070761001235484930421656464")

        res = a * a

        XCTAssertEqual(res, c, res.toHexString)

        res = 0

        a = UInt256(decimalString: "4514341311903373517")
        c = UInt256(decimalString: "20379277480357471495929005285216949289")

        res = a * a

        XCTAssertEqual(res, c, res.toHexString)

        res = 0

        a = UInt256(decimalString: "8324499029011133232")
        c = UInt256(decimalString: "69297284084007299998947387404854765824")

        measure {
            for _ in 1 ... million / 100 {
                res = a * a
            }
        }

        XCTAssertEqual(res, c, res.toHexString)
    }

    func testMultiplyToMax128BitWithKaratsubaOverflow() {
        var a = UInt256(decimalString: "6907831480921755401") // Also overflows res[1]+= z1 >> 32
        var c = UInt256(hexString: "23e62dbc72dfd1301d69c1b13fb60e51")

        var res: UInt256 = 0

        res = a * a // result[0] is 1 to high

        XCTAssertEqual(res, c, res.toHexString)

        a = UInt256(decimalString: "8865396608531244567")
        c = UInt256(hexString: "3b20e559aa2e5076fa2b512bdeb0d611")

        res = a * a // result[0] is 1 to high

        XCTAssertEqual(res, c, res.toHexString)

        a = UInt256(decimalString: "9654263533683468436")
        c = UInt256(decimalString: "93204804377810410884729817879008286096")

        res = a * a

        XCTAssertEqual(res, c, res.toHexString)

        a = UInt256(decimalString: "18446744073709551614") // 0.9999999...% of 128 bit max
        c = UInt256(decimalString: "340282366920938463389587631136930004996")

        measure {
            for _ in 1 ... million / 100 {
                res = a * a // 0.9999999...% of 128 bit max
            }
        }

        XCTAssertEqual(res, c, res.toHexString)
    }

    func testMultiplyToMax128BitWithKaratsubaOverflowPart2() {
        var a: UInt256 = UInt256(decimalString: "9654263533683468436")
        var c: UInt256 = UInt256(hexString: "461e97a5a38a54c61541d2cd28949590")

        var res: UInt256 = a * a // Overflow 1 to high

        XCTAssertEqual(res, c, res.toHexString)

        a = UInt256(decimalString: "18446744073709551614") // 0.9999999...% of 128 bit max
        c = UInt256(decimalString: "340282366920938463389587631136930004996")

        res = a * a

        XCTAssertEqual(res, c, res.toHexString)
    }

    func testMultiplyToMax256Bit() {
        let a = UInt256(decimalString: "340282366920938463463374607431768211455")
        let c = UInt256(decimalString: "115792089237316195423570985008687907852589419931798687112530834793049593217025")

        var res: UInt256 = 0

        measure {
            for _ in 1 ... million / 100 {
                res = a * a // 0.9999999...% of UInt256 max
            }
        }

        XCTAssertEqual(res, c, res.description)
    }

    func testMultiplicationToTupleWithoutRecursion() {
        let p = UInt256(0xFFFF_FFFF, 0xFFFF_FFFF, 0xFFFF_FFFF, 0xFFFF_FFFF, 0xFFFF_FFFF, 0xFFFF_FFFF, 0xFFFF_FFFE, 0xFFFF_FC2F)

        // a and b chosen such that x₁ + x₀ and y₁_plus_y₀ don't overflow
        let a = UInt256(0x502B_5092, 0x9D7B_11ED, 0x52D0_0E63, 0x11CD_10FF, 0x9295_6188, 0xDD56_6BC4, 0x52D0_EBAA, 0x95F8_234C)

        let b = UInt256(0x17C1_0759, 0xF6E1_28F2, 0x0704_C711, 0x914F_A8BF, 0xAA51_4B51, 0xA371_522D, 0xFC5B_D655, 0x1620_50CE)

        let (left, right) = (UInt256(0x0770_5732, 0x4641_EFFD, 0x378F_46BC, 0x92ED_EC71, 0x75C3_1FAF, 0xC2E2_1A5D, 0x69BF_BB9F, 0x07AB_D941), UInt256(0x98BA_AAE0, 0xF56E_67D7, 0x455C_1CE2, 0x8617_A3A9, 0xC9CD_081A, 0x1AFB_578A, 0xA0E2_446B, 0x2A34_2728))

        let product = UInt256(0x42B9_61BC, 0x4EA2_93F4, 0xE216_FF00, 0xB9DE_205B, 0xFA5B_103E, 0x45A1_B1AA, 0x44B9_7F03, 0xD4C9_7CB8)

        var resLeft: UInt256 = 0
        var resRight: UInt256 = 0

        measure {
            for _ in 1 ... million / 1000 {
                (resLeft, resRight) = a * b
            }
        }

        XCTAssertTrue(resLeft == left, resLeft.description)
        XCTAssertTrue(resRight == right, resRight.description)
    }

    func testMultiplicationInSecp256k1() {
        let a = UInt256(0x9B99_2796, 0x1923_7FAF, 0x0C13_C344, 0x614C_46A9, 0xE735_7341, 0xC6E4_E042, 0xA9B1_311A, 0x8622_DEAA)

        let b = UInt256(0xE7F1_CAA6, 0x36BA_A277, 0x9CFD_6CF9, 0x696C_F826, 0xF013_DB03, 0x7AA0_8F3D, 0x5C2D_FAF9, 0xDB5D_255B)

        let (left, right) = (UInt256(0x8CFA_2912, 0x94CC_8C2C, 0x827A_9EF6, 0x977F_6B69, 0x1D24_B810, 0xF085_C437, 0xABD1_3F27, 0x942D_A0B5), UInt256(0xEDE9_73CF, 0x7A14_DB61, 0x0DFE_857E, 0x382B_C650, 0x71AF_459E, 0x2742_5F0C, 0x36B6_7051, 0x0A55_B86E))

        let product = UInt256(0x896C_BFE5, 0xDD32_7035, 0x9B76_9BFF, 0x8299_6A89, 0x9B57_827B, 0xC195_76AB, 0x1170_4459, 0x9336_D1F0)

        var resLeft: UInt256 = 0
        var resRight: UInt256 = 0

        measure {
            for _ in 0 ... (million / 1000) {
                (resLeft, resRight) = a * b
            }
        }

        XCTAssertTrue(resLeft == left, resLeft.description)
        XCTAssertTrue(resRight == right, resRight.description)
    }

    func testModTupleInSecp256k1() {
        let p = UInt256(0xFFFF_FFFF, 0xFFFF_FFFF, 0xFFFF_FFFF, 0xFFFF_FFFF, 0xFFFF_FFFF, 0xFFFF_FFFF, 0xFFFF_FFFE, 0xFFFF_FC2F)

        let (left, right) = (UInt256(0x8CFA_2912, 0x94CC_8C2C, 0x827A_9EF6, 0x977F_6B69, 0x1D24_B810, 0xF085_C437, 0xABD1_3F27, 0x942D_A0B5), UInt256(0xEDE9_73CF, 0x7A14_DB61, 0x0DFE_857E, 0x382B_C650, 0x71AF_459E, 0x2742_5F0C, 0x36B6_7051, 0x0A55_B86E))

        let mod = UInt256(0x896C_BFE5, 0xDD32_7035, 0x9B76_9BFF, 0x8299_6A89, 0x9B57_827B, 0xC195_76AB, 0x1170_4459, 0x9336_D1F0)

        var result: UInt256 = 0

        measure {
            for _ in 1 ... (million / 100) {
                result = (left, right) % p
            }
        }

        XCTAssertTrue(result == mod, result.description)
    }
    
}
