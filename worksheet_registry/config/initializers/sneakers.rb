Sneakers.configure  heartbeat: 20,
                    amqp: 'amqp://guest:guest@172.21.0.1:5672',
                    vhost: '/',
                    durable: true,
                    ack: true,
                    threads: 10,
                    prefetch: 10,
                    timeout_job_after: 90,
                    # :daemonize => true,
                    workers: 4,
                    log: './log/sneakers.log',
                    pid_path: './tmp/sneakers.pid',
                    log_level: 4
                    # log_stderr: true
