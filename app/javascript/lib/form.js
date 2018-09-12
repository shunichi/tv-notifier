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
  $checkForm.find('input[type="text"]').on('keyup', (e) => {
    updateButtonStatus($(e.currentTarget).closest('form'));
  });
  updateButtonStatus($checkForm);
});