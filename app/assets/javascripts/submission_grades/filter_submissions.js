/* JS goes here */
$(document).ready(function(){

    $('#filter-submissions-mentor').on('load', function () {
        $.get('filter_submissions', function (data, status) {
            if (status == true)
                render_list_submissions(data);
            else {
                alert('Something wrong when load data')
            }
        })
    })

    function render_list_submissions(data) {

    }
});
