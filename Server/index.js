const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

// Mock employee data
const employees = [
    { id: 1, name: 'John Doe', joinDate: '2017-04-15', active: true },
    { id: 2, name: 'Jane Smith', joinDate: '2018-01-20', active: true },
    { id: 3, name: 'Alice Johnson', joinDate: '2019-09-10', active: false },
    { id: 4, name: 'Bob Brown', joinDate: '2016-11-30', active: true },
];



app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});


app.get("/api/get_list",(req,res)=>{
    if (employees.length>0) {
        res.status(200).send({
            'status_code':200,
            'employee_list':employees



        })
        
    }




})


app.put("/api/add_employee",(req,res)=>{

    const new_employee= {
        id: employees.length+1, 
        name: req.body.name,
         joinDate: req.body.joinDate,
          active: req.body.active 



    };

    employees.push(new_employee);
    console.log("New employee add succesfully");




})