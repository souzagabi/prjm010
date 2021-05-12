function sumTotal(qtde, elementValue, elementTotal)
{
    if (elementValue.value !== '') {
        elementValue.value = replaceComa(elementValue);
    }
    if (qtde > 0 && elementValue.value > 0) {
        var total =  qtde * elementValue.value;
        var average = total / qtde;
        document.getElementById(elementTotal.name).value = total.toFixed(2);
        
        if (elementTotal.name == "tlbuy") {
            document.getElementById("bprcaverage").value = average.toFixed(2);
        } else
        {
            document.getElementById("sprcaverage").value = average.toFixed(2);
            var vlbuy = document.getElementById("prcbuy").value * qtde;
            var vlsell = elementTotal.value;
            
    
            if (vlbuy && vlsell) {
                var lucre = vlsell - vlbuy;
                if (lucre < 0 || lucre > 0) {
                    var tax = ((lucre*100)/vlbuy);
                    document.getElementById("tax").value = tax.toFixed(2)+" %";
                }
            }
            document.getElementById("lucre").value = lucre.toFixed(2);
        }
      
    }

    return total;
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
    
