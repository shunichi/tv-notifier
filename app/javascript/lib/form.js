import $ from 'jquery';

const hasBlankField = ($form) => {
  return $form.find('input[type="text"]').filter((_, elem) => elem.value === '').length  > 0;
};

const updateButtonStatus = ($form) => {
  const hasBlank = hasBlankField($form);
  $form.find('button').prop('disabled', hasBlank);
};

$(() => {
  const $checkForm = $('.js-presence-check');
  $checkForm.on('change', (e) => {
    updateButtonStatus($(e.currentTarget));
  });
  updateButtonStatus($checkForm);
});