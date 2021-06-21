function insertcolor(element,elementCompare)
{
    if (element.value != '') {

        var d2 = compareDate(element.value);
       
        element.classList.remove("programado");
        element.classList.remove("efetuado");
        element.classList.remove("atrasado");
        element.classList.remove("antecipado");
        element.classList.remove("naoexecutou");
        
        if (elementCompare.value == '0') 
        {
            if (d2 === "menor") 
            {
                element.classList.add("atrasado");
            } else if (d2 === "maior") 
            {
                element.classList.add("programado");
            } else
            {
                element.classList.add("programado");
            } 
            
        }
        if (elementCompare.value == '1') 
        {
            if (d2 === "menor") 
            {
                element.classList.add("atrasado");
            } 
            if (d2 === "igual") 
            {
                element.classList.add("efetuado");
            } 
            if (d2 === "maior") 
            {
                element.classList.add("antecipado");
            }
        }
        if (elementCompare.value == '2') {
            element.classList.add("naoexecutou");
        }
        
    }
}

function compareDate(date)
{
    var viewdate = date.split('-');
    var d1 = new Date(viewdate[2],viewdate[1]-1,viewdate[0]);
    
    var today = new Date();
    var dta = new Date(today.getFullYear(),today.getMonth(),today.getDate());
        
    var d2 = '';
    if (d1 > dta)  
    { 
        d2 = 'maior';
    } else if (d1 < dta)  
    { 
        d2 = 'menor';
    } else 
    { 
        d2 = 'igual';
    } 
    return d2;
}

function replaceComa(element)
{
    var v = element.value.replace(/,/g, '.');
    document.getElementById(element.name).value = v;
    return v ;
}
function replaceSlash(element)
{
    var dt = element.value.replace(/[\/\-]/g, '-');
    document.getElementById(element.name).value = dt;
}

function convertLowToUpper(element)
{
    var company = element.value;

    if(company != '' || company != NULL)
    {
        document.getElementById(element.name).value = company.toUpperCase();
        
    }
}

function verifyConfPassWord(element, elementCompare, elementMsg)
{
    var msg = '';
    
    if (element.value != '' && elementCompare.value != '') {
        
        if (element.value != elementCompare.value) {
            msg = "Senha não confere! Digite-a novamente.";
           
        } else if (element.value == elementCompare.value) {
            if (element.value.length < 6) {
                msg = "A senha tem que ser pelo menos 6 caracteres!!";
            } else {
                console.log(document.getElementById("btnSubmit"));
                document.getElementById("btnSubmit").style.display = "inline";
            }
        } 
        if (msg != '') {
            elementMsg.style.display = "block";
            document.getElementById("btnSubmit").style.display = "none";
            document.getElementById("msgDanger").innerHTML = msg;
            elementCompare.focus();
            removeMensagemError(elementMsg);
        }
    } else {
       document.getElementById("btnSubmit").style.display = "none";
    }
}

function removeMensagemError(element){
    if (element) {
        setTimeout(function(){ 
            element.style.display = "none";  
            document.getElementById("msgError").innerHTML = "";
        }, 2000);
    }
}

function removeMensagem(){
    if (document.getElementById("msg-success")) {
        setTimeout(function(){ 
            var msg = document.getElementById("msg-success");
            msg.parentNode.removeChild(msg);   
        }, 2000);
    }
    if (document.getElementById("msg-danger")) {
        setTimeout(function(){ 
            var msg = document.getElementById("msg-danger");
            msg.parentNode.removeChild(msg);   
        }, 2000);
    }
}
document.onreadystatechange = () => {
    if (document.readyState === 'complete') {
        removeMensagem(); 
    }
};
