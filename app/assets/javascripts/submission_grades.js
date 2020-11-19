$(document).ready(function() {
  $('#daterange-btn').daterangepicker(
    {
      ranges   : {
        'Today'       : [moment(), moment()],
        'Yesterday'   : [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
        'Last 7 Days' : [moment().subtract(6, 'days'), moment()],
        'Last 30 Days': [moment().subtract(29, 'days'), moment()],
        'This Month'  : [moment().startOf('month'), moment().endOf('month')],
        'Last Month'  : [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
      },
      startDate: moment().subtract(29, 'days'),
      endDate  : moment()
    },
    function (start, end) {
      $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
    }
  )

  // $('#btnSubmitGrade').on('click', (event) => {
  //   event.preventDefault();
  //   alert('Clicked')
  //   getFormInput()
  //   $('#gradeForm').submit()
  // })

  $('#confirmSendGradeBtn').click((event) => {
    console.log('clicked')
    $('#confirmSendGradeForm').submit()
  })
})

