# Aliases
alias ssc 'sudo systemctl'
alias ssce 'sudo systemctl enable'
alias sscd 'sudo systemctl disable'
alias sscs 'sudo systemctl start'
alias ssct 'sudo systemctl stop'
alias sscr 'sudo systemctl restart'
alias sscst 'sudo systemctl status'
alias sscdr 'sudo systemctl daemon-reload'

function eu # Edit unit file and reload daemon
    sudo nano /usr/lib/systemd/system/$argv[1]
    sudo systemctl daemon-reload
end

function ru # Reload unit file and follow logs
    sudo systemctl restart $argv[1]
    sudo journalctl -u $argv[1] -f
end

function sch # Perform a service check
    for SERVICE in $argv
        if sudo systemctl is-active $SERVICE --quiet
            echo 🟢 $SERVICE is active.
        else
            echo 🔴 $SERVICE is inactive.
        end
    end
end

function rch # Restart services and perform a service check
    for SERVICE in $argv
        if sudo systemctl is-active $SERVICE --quiet
            echo 🟢 $SERVICE is active, restarting...
            sudo systemctl restart $SERVICE
        else
            echo 🔴 $SERVICE is inactive, starting...
            sudo systemctl restart $SERVICE
        end

        sleep 10

        if sudo systemctl is-active $SERVICE --quiet
            echo 🟢 $SERVICE is active.
        else
            echo 🔴 $SERVICE is inactive.
        end
    end
end
