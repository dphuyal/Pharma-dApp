console.log("Log 1");
var web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));
//After I set provider, I was able to get the account (public key) of the localhost provider
web3.eth.defaultAccount = web3.eth.accounts[0];
const userAccessAccount = web3.eth.defaultAccount;
console.log(userAccessAccount);
//ABI (Abstract Binary Interface)After contract is deployed, found in remix. 
const contractAbi=[
	{
		"constant": false,
		"inputs": [
			{
				"internalType": "string",
				"name": "_patientId",
				"type": "string"
			}
		],
		"name": "getPrescription",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "isget",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"internalType": "string",
				"name": "_docId",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_docName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_docState",
				"type": "string"
			}
		],
		"name": "addDoctor",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "prescriptionCounter",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"internalType": "string",
				"name": "_state",
				"type": "string"
			}
		],
		"name": "surveyDrug",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "isadd",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"internalType": "string",
				"name": "_docId",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_docState",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_patientId",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_drugName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_brandName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_dosage",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_numPills",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_fillDate",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_expDate",
				"type": "string"
			}
		],
		"name": "addPrescription",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "constructor"
	}
];
//Found in remix too
const contractAddress='0x4CE695D94a407270c985467AFff356ee8eac057b';
const contract=web3.eth.contract(contractAbi).at(contractAddress);

if(document.querySelector("#prescription_form")){
document.querySelector("#prescription_form").addEventListener("submit",function(event){
    event.preventDefault();
    const license_num=document.querySelector("#license-num").value;
    const license_state=document.querySelector("#license-state").value;
    const patient_id=document.querySelector("#patient-id").value;
    const drug_name=document.querySelector("#drug-name").value;
    const brand_name=document.querySelector("#brand-name").value;
    const dosage=document.querySelector("#dosage").value;
    const num_pills=document.querySelector("#num-pills").value;
    var date_filled=document.querySelector("#date-filled").value;
    var expiry_date=document.querySelector("#expiry-date").value;
    date_filled=date_filled.split("-");
    expiry_date=expiry_date.split("-");
    date_filled=date_filled[0]+date_filled[1]+date_filled[2];
    expiry_date=expiry_date[0]+expiry_date[1]+expiry_date[2];
    console.log(license_num, license_state, patient_id, drug_name, brand_name, dosage, num_pills, date_filled, expiry_date);
    contract.addPrescription(license_num,license_state,patient_id,drug_name,brand_name,dosage,num_pills,date_filled,expiry_date);  
});
}

document.querySelector("#resultform_form").addEventListener("submit",function(event){
    event.preventDefault();
    const state=document.querySelector("#research-state").value;
    contract.surveyDrug(state,function(error,message){
        console.log(message);
        const display=document.querySelector("#display_msg");
        if(error){
            display.innerHTML="Cannot find the record";
        }
        display.innerHTML="The most used brand of drug is "+document.querySelector("#research-state").value+" is "+message;

    });
});




