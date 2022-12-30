enum Currency {
  cad,
  usd,
  eur,
  aud,
  gbp,
  cny,
  pln,
  myr,
}

enum StatusMethodPayment {
  available,
  unavailable,
}

List<Map<String, dynamic>> paymentMethod = [
  {
    "name": "acss_debit",
    "status": StatusMethodPayment.unavailable,
    "currency": "cad",
  },
  {
    "name": "affirm",
    "status": StatusMethodPayment.unavailable,
    "currency": "usd",
  },
  {
    "name": "afterpay_clearpay",
    "status": StatusMethodPayment.unavailable,
    "currency": "usd",
  },
  {
    "name": "alipay",
    "status": StatusMethodPayment.available,
    "currency": "cny",
  },
  {
    "name": "au_becs_debit",
    "status": StatusMethodPayment.unavailable,
    "currency": "aud",
  },
  {
    "name": "bacs_debit",
    "status": StatusMethodPayment.unavailable,
    "currency": "gbp",
  },
  {
    "name": "bancontact",
    "status": StatusMethodPayment.unavailable,
    "currency": "eur",
  },
  {
    "name": "blik",
    "status": StatusMethodPayment.unavailable,
    "currency": "pln",
  },
  {
    "name": "boleto",
    "status": StatusMethodPayment.unavailable,
    "currency": "usd",
  },
  {
    "name": "card",
    "status": StatusMethodPayment.available,
    "currency": "usd",
  },
  {
    "name": "eps",
    "status": StatusMethodPayment.unavailable,
    "currency": "eur",
  },
  {
    "name": "fpx",
    "status": StatusMethodPayment.unavailable,
    "currency": "myr",
  },
  {
    "name": "giropay",
    "status": StatusMethodPayment.unavailable,
    "currency": "eur",
  },
  {
    "name": "grabpay",
    "status": StatusMethodPayment.unavailable,
    "currency": "myr",
  },
];
