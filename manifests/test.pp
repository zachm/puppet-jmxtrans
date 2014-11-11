class jmxtrans::test::metrics::multiple {
  jmxtrans::metrics { 'service_a':
    jmx     => 'service_a:1099',
    objects => [
      {
        'name'  => "some.service_a:type=thing",
        'attrs' => {
          'SomethingSpeed' => { 'units' => 'Attoparsecs per microfortnight' }
        }
      }
    ]
  }

  jmxtrans::metrics { 'service_b':
    jmx     => 'service_b:1099',
    objects => [
      {
        'name'  => "some.service_b:type=thing",
        'attrs' => {
          'SomethingSpeed' => { 'units' => 'Attoparsecs per microfortnight' }
        }
      }
    ]
  }
}

class jmxtrans::test::metrics::duplicate {
  jmxtrans::metrics { 'service_a':
    jmx     => 'service_a:1099',
    objects => [
      {
        'name'  => "some.service_a:type=thing",
        'attrs' => {
          'SomethingSpeed' => { 'units' => 'Attoparsecs per microfortnight' }
        }
      }
    ]
  }

  jmxtrans::metrics { 'service_a':
    jmx     => 'service_a:1099',
    objects => [
      {
        'name'  => "some.service_a:type=thing",
        'attrs' => {
          'SomethingSpeed' => { 'units' => 'Attoparsecs per microfortnight' }
        }
      }
    ]
  }
}
