//: Playground - noun: a place where people can play

import UIKit
import Foundation

var data = [
    [
        "title": "GENERAL INFO",
        "rows": [
            [
                "placeholder": "First Name",
                "cellType": "general",
                ],
            [
                "placeholder": "Last Name",
                "cellType": "general",
                ],
            [
                "placeholder": "Email",
                "cellType": "general",
                ],
            [
                "placeholder": "Phone",
                "cellType": "general",
                ]
        ]
    ],
    [
        "title": "ADDRESS",
        "rows": [
            [
                "placeholder": "Address Line 1",
                "cellType": "address",
                ],
            [
                "placeholder": "Address Line 2",
                "cellType": "address",
                ],
            [
                "placeholder": "City",
                "cellType": "address",
                ],
            [
                "placeholder": "Zip Code",
                "cellType": "address",
                ],
            [
                "placeholder": "State",
                "cellType": "address",
                ],
            [
                "placeholder": "Country",
                "cellType": "address",
                ]
        ]
    ],
    [
        "title" : "IMPORTANT DATES",
        "rows": [
            [
                "placeholder": "Birthday",
                "cellType": "general",
                ],
            [
                "placeholder": "Anniversary",
                "cellType": "general",
                ]
        ]
    ],
    [
        "title" : "PASSWORD",
        "rows": [
            [
                "placeholder": "New Password",
                "cellType": "general",
                ],
            [
                "placeholder": "Confirm Password",
                "cellType": "general",
                ]
        ]
    ]
]


print("Data Value Count : \(data[3]))")


